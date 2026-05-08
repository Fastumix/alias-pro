import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { CategoriesModule } from "../categories/categories.module";
import { GameResult } from "./game-result.entity";
import { GamesController } from "./games.controller";
import { GamesService } from "./games.service";
import { Word } from "./word.entity";

@Module({
  imports: [TypeOrmModule.forFeature([GameResult, Word]), CategoriesModule],
  providers: [GamesService],
  controllers: [GamesController],
})
export class GamesModule {}
