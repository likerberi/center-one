import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { HttpService } from '@nestjs/axios';
import { CacheService } from '../cache/cache.service';
import { firstValueFrom } from 'rxjs';

export interface GithubActivity {
  totalCommits: number;
  totalPRs: number;
  totalIssues: number;
  recentEvents: any[];
  contributions: any[];
}

@Injectable()
export class GithubService {
  private readonly apiUrl = 'https://api.github.com';
  private readonly cacheKey = 'github:activity';
  private readonly cacheTTL = 3600; // 1시간

  constructor(
    private configService: ConfigService,
    private httpService: HttpService,
    private cacheService: CacheService,
  ) {}

  async getActivity(username?: string): Promise<GithubActivity> {
    const user = username || this.configService.get('GITHUB_USERNAME');

    if (!user) {
      throw new Error('GitHub username is not configured');
    }

    // 캐시 확인
    const cached = await this.cacheService.get<GithubActivity>(this.cacheKey);
    if (cached) {
      return cached;
    }

    // GitHub API 호출
    const token = this.configService.get('GITHUB_TOKEN');
    const headers = token ? { Authorization: `token ${token}` } : {};

    try {
      // 이벤트 가져오기
      const eventsResponse = await firstValueFrom(
        this.httpService.get(`${this.apiUrl}/users/${user}/events`, { headers }),
      );

      // 레포지토리 가져오기
      const reposResponse = await firstValueFrom(
        this.httpService.get(`${this.apiUrl}/users/${user}/repos`, { headers }),
      );

      const events = eventsResponse.data;
      const repos = reposResponse.data;

      // 통계 계산
      const commits = events.filter((e) => e.type === 'PushEvent');
      const prs = events.filter((e) => e.type === 'PullRequestEvent');
      const issues = events.filter((e) => e.type === 'IssuesEvent');

      const activity: GithubActivity = {
        totalCommits: commits.length,
        totalPRs: prs.length,
        totalIssues: issues.length,
        recentEvents: events.slice(0, 10),
        contributions: this.calculateContributions(events),
      };

      // 캐시 저장
      await this.cacheService.set(this.cacheKey, activity, this.cacheTTL);

      return activity;
    } catch (error) {
      throw new Error(`Failed to fetch GitHub data: ${error.message}`);
    }
  }

  private calculateContributions(events: any[]): any[] {
    const contributionMap = new Map<string, number>();

    events.forEach((event) => {
      const date = new Date(event.created_at).toISOString().split('T')[0];
      contributionMap.set(date, (contributionMap.get(date) || 0) + 1);
    });

    return Array.from(contributionMap.entries())
      .map(([date, count]) => ({ date, count }))
      .sort((a, b) => b.date.localeCompare(a.date));
  }
}
