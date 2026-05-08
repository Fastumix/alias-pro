import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { Word } from "../games/word.entity";
import { Category } from "./category.entity";

@Injectable()
export class CategoriesService {
  constructor(
    @InjectRepository(Category)
    private readonly categoriesRepo: Repository<Category>,
    @InjectRepository(Word)
    private readonly wordsRepo: Repository<Word>,
  ) {}

  findAll(): Promise<Category[]> {
    return this.categoriesRepo.find();
  }

  async findOne(slug: string): Promise<Category> {
    const cat = await this.categoriesRepo.findOneBy({ slug });
    if (!cat) throw new NotFoundException(`Category "${slug}" not found`);
    return cat;
  }

  /** Returns a random batch of words for a game round. */
  async getWords(categorySlug: string, limit = 50): Promise<Word[]> {
    const cat = await this.findOne(categorySlug);
    return this.wordsRepo
      .createQueryBuilder("word")
      .where("word.categoryId = :id", { id: cat.id })
      .orderBy("RANDOM()")
      .limit(limit)
      .getMany();
  }
}
