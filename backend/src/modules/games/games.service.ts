import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { CategoriesService } from "../categories/categories.service";
import { SaveGameResultDto } from "./dto/save-game-result.dto";
import { GameResult } from "./game-result.entity";

@Injectable()
export class GamesService {
  constructor(
    @InjectRepository(GameResult)
    private readonly resultsRepo: Repository<GameResult>,
    private readonly categoriesService: CategoriesService,
  ) {}

  async saveResult(
    userId: string,
    dto: SaveGameResultDto,
  ): Promise<GameResult> {
    const category = await this.categoriesService.findOne(dto.categorySlug);
    const result = this.resultsRepo.create({
      userId,
      categoryId: category.id,
      teamName: dto.teamName,
      round: dto.round,
      score: dto.score,
      correctCount: dto.correctCount ?? 0,
      skipCount: dto.skipCount ?? 0,
      timeRound: dto.timeRound ?? 60,
    });
    return this.resultsRepo.save(result);
  }

  findUserResults(userId: string): Promise<GameResult[]> {
    return this.resultsRepo.find({
      where: { userId },
      order: { playedAt: "DESC" },
      take: 50,
    });
  }

  async findOne(id: string): Promise<GameResult> {
    const r = await this.resultsRepo.findOneBy({ id });
    if (!r) throw new NotFoundException(`Game result ${id} not found`);
    return r;
  }

  /** Random words for an in-progress game round. */
  getWords(categorySlug: string, limit?: number) {
    return this.categoriesService.getWords(categorySlug, limit);
  }
}
