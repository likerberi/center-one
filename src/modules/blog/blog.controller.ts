import { Controller, Get, Query } from '@nestjs/common';
import { BlogService } from './blog.service';

@Controller('api/blog')
export class BlogController {
  constructor(private readonly blogService: BlogService) {}

  @Get('activity')
  async getActivity(@Query('rssUrl') rssUrl?: string) {
    return this.blogService.getActivity(rssUrl);
  }
}
