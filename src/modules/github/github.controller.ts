import { Controller, Get, Query } from '@nestjs/common';
import { GithubService } from './github.service';

@Controller('api/github')
export class GithubController {
  constructor(private readonly githubService: GithubService) {}

  @Get('activity')
  async getActivity(@Query('username') username?: string) {
    return this.githubService.getActivity(username);
  }
}
