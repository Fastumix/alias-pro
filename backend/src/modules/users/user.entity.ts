import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true, nullable: true })
  email: string | null;

  @Column({ nullable: true, select: false })
  passwordHash: string | null;

  @Column({ default: 'anonymous' })
  displayName: string;

  @Column({ nullable: true })
  avatarEmoji: string | null;

  @Column({ default: 0 })
  coinBalance: number;

  @Column({ default: false })
  isAnonymous: boolean;

  @Column({ nullable: true })
  firebaseUid: string | null;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;
}
