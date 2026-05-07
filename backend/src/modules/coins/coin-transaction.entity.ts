import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  JoinColumn,
} from 'typeorm';
import { User } from '../users/user.entity';

export enum CoinTransactionType {
  CREDIT = 'credit',
  DEBIT = 'debit',
}

@Entity('coin_transactions')
export class CoinTransaction {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @ManyToOne(() => User, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'userId' })
  user: User;

  @Column()
  userId: string;

  @Column({ type: 'int' })
  amount: number; // always positive; type determines direction

  @Column({ type: 'enum', enum: CoinTransactionType })
  type: CoinTransactionType;

  @Column({ default: '' })
  reason: string; // e.g. "round_complete", "purchase", "bonus"

  @CreateDateColumn()
  createdAt: Date;
}
