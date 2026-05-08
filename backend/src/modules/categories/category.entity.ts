import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Word } from "../games/word.entity";

@Entity("categories")
export class Category {
  @PrimaryGeneratedColumn("uuid")
  id: string;

  @Column({ unique: true })
  slug: string; // e.g. "beginner" | "player" | "pro"

  @Column()
  name: string;

  @Column({ nullable: true })
  description: string | null;

  @Column({ default: false })
  isPremium: boolean;

  @OneToMany(() => Word, (word) => word.category)
  words: Word[];
}
