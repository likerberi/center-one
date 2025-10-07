import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { GithubModule } from './modules/github/github.module';
import { BlogModule } from './modules/blog/blog.module';
import { CacheModule } from './modules/cache/cache.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    GithubModule,
    BlogModule,
    CacheModule,
  ],
})
export class AppModule {}
