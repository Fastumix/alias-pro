import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GameResult } from './game-result.entity';
import { Word } from './word.entity';
import { GamesService } from './games.service';
import { GamesController } from './games.controller';
import { CategoriesModule } from '../categories/categories.module';

@Module({
  imports: [TypeOrmModule.forFeature([GameResult, Word]), CategoriesModule],
  providers: [GamesService],
  controllers: [GamesController],
})
export class GamesModule {}
