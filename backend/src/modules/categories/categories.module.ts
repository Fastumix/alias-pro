import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { Word } from "../games/word.entity";
import { CategoriesController } from "./categories.controller";
import { CategoriesService } from "./categories.service";
import { Category } from "./category.entity";

@Module({
  imports: [TypeOrmModule.forFeature([Category, Word])],
  providers: [CategoriesService],
  controllers: [CategoriesController],
  exports: [CategoriesService],
})
export class CategoriesModule {}
