import {
    Column,
    CreateDateColumn,
    Entity,
    JoinColumn,
    ManyToOne,
    PrimaryGeneratedColumn,
} from "typeorm";
import { Category } from "../categories/category.entity";
import { User } from "../users/user.entity";

@Entity("game_results")
export class GameResult {
  @PrimaryGeneratedColumn("uuid")
  id: string;

  @ManyToOne(() => User, { onDelete: "SET NULL", nullable: true })
  @JoinColumn({ name: "userId" })
  user: User | null;

  @Column({ nullable: true })
  userId: string | null;

  @ManyToOne(() => Category, { onDelete: "SET NULL", nullable: true })
  @JoinColumn({ name: "categoryId" })
  category: Category | null;

  @Column({ nullable: true })
  categoryId: string | null;

  @Column()
  teamName: string;

  @Column({ default: 1 })
  round: number;

  @Column({ default: 0 })
  score: number;

  @Column({ default: 0 })
  correctCount: number;

  @Column({ default: 0 })
  skipCount: number;

  @Column({ type: "int", default: 60 })
  timeRound: number;

  @CreateDateColumn()
  playedAt: Date;
}
