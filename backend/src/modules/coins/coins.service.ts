import {
    BadRequestException,
    Injectable,
    NotFoundException,
} from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { DataSource, Repository } from "typeorm";
import { User } from "../users/user.entity";
import {
    CoinTransaction,
    CoinTransactionType,
} from "./coin-transaction.entity";

@Injectable()
export class CoinsService {
  constructor(
    @InjectRepository(CoinTransaction)
    private readonly txRepo: Repository<CoinTransaction>,
    @InjectRepository(User)
    private readonly usersRepo: Repository<User>,
    private readonly dataSource: DataSource,
  ) {}

  async getBalance(userId: string): Promise<number> {
    const user = await this.usersRepo.findOneBy({ id: userId });
    if (!user) throw new NotFoundException("User not found");
    return user.coinBalance;
  }

  async credit(userId: string, amount: number, reason = ""): Promise<void> {
    if (amount <= 0) throw new BadRequestException("Amount must be positive");
    await this.dataSource.transaction(async (em) => {
      await em.increment(User, { id: userId }, "coinBalance", amount);
      await em.save(CoinTransaction, {
        userId,
        amount,
        type: CoinTransactionType.CREDIT,
        reason,
      });
    });
  }

  async debit(userId: string, amount: number, reason = ""): Promise<void> {
    if (amount <= 0) throw new BadRequestException("Amount must be positive");
    await this.dataSource.transaction(async (em) => {
      const user = await em.findOneByOrFail(User, { id: userId });
      if (user.coinBalance < amount)
        throw new BadRequestException("Insufficient coins");
      await em.decrement(User, { id: userId }, "coinBalance", amount);
      await em.save(CoinTransaction, {
        userId,
        amount,
        type: CoinTransactionType.DEBIT,
        reason,
      });
    });
  }

  getHistory(userId: string): Promise<CoinTransaction[]> {
    return this.txRepo.find({
      where: { userId },
      order: { createdAt: "DESC" },
      take: 100,
    });
  }
}
