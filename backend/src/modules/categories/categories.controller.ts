import { Controller, Get, Param, Query, UseGuards } from "@nestjs/common";
import { ApiBearerAuth, ApiQuery, ApiTags } from "@nestjs/swagger";
import { JwtAuthGuard } from "../auth/guards/jwt-auth.guard";
import { CategoriesService } from "./categories.service";

@ApiTags("categories")
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller({ path: "categories", version: "1" })
export class CategoriesController {
  constructor(private readonly categoriesService: CategoriesService) {}

  @Get()
  findAll() {
    return this.categoriesService.findAll();
  }

  @Get(":slug")
  findOne(@Param("slug") slug: string) {
    return this.categoriesService.findOne(slug);
  }

  @ApiQuery({ name: "limit", required: false, type: Number })
  @Get(":slug/words")
  getWords(@Param("slug") slug: string, @Query("limit") limit?: number) {
    return this.categoriesService.getWords(slug, limit);
  }
}
