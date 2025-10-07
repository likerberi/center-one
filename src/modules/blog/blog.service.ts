import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { CacheService } from '../cache/cache.service';
import * as Parser from 'rss-parser';

export interface BlogPost {
  title: string;
  link: string;
  pubDate: string;
  content?: string;
  categories?: string[];
}

export interface BlogActivity {
  totalPosts: number;
  recentPosts: BlogPost[];
  postsPerMonth: any[];
}

@Injectable()
export class BlogService {
  private parser: Parser;
  private readonly cacheKey = 'blog:activity';
  private readonly cacheTTL = 3600; // 1시간

  constructor(
    private configService: ConfigService,
    private cacheService: CacheService,
  ) {
    this.parser = new Parser();
  }

  async getActivity(rssUrl?: string): Promise<BlogActivity> {
    const url = rssUrl || this.configService.get('BLOG_RSS_URL');

    if (!url) {
      throw new Error('Blog RSS URL is not configured');
    }

    // 캐시 확인
    const cached = await this.cacheService.get<BlogActivity>(this.cacheKey);
    if (cached) {
      return cached;
    }

    try {
      const feed = await this.parser.parseURL(url);

      const posts: BlogPost[] = feed.items.map((item) => ({
        title: item.title || '',
        link: item.link || '',
        pubDate: item.pubDate || '',
        content: item.contentSnippet || item.content,
        categories: item.categories,
      }));

      const activity: BlogActivity = {
        totalPosts: posts.length,
        recentPosts: posts.slice(0, 10),
        postsPerMonth: this.calculatePostsPerMonth(posts),
      };

      // 캐시 저장
      await this.cacheService.set(this.cacheKey, activity, this.cacheTTL);

      return activity;
    } catch (error) {
      throw new Error(`Failed to fetch blog RSS: ${error.message}`);
    }
  }

  private calculatePostsPerMonth(posts: BlogPost[]): any[] {
    const monthMap = new Map<string, number>();

    posts.forEach((post) => {
      if (post.pubDate) {
        const date = new Date(post.pubDate);
        const monthKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`;
        monthMap.set(monthKey, (monthMap.get(monthKey) || 0) + 1);
      }
    });

    return Array.from(monthMap.entries())
      .map(([month, count]) => ({ month, count }))
      .sort((a, b) => b.month.localeCompare(a.month));
  }
}
