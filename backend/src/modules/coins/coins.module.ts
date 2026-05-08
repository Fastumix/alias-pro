import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { User } from "../users/user.entity";
import { CoinTransaction } from "./coin-transaction.entity";
import { CoinsController } from "./coins.controller";
import { CoinsService } from "./coins.service";

@Module({
  imports: [TypeOrmModule.forFeature([CoinTransaction, User])],
  providers: [CoinsService],
  controllers: [CoinsController],
  exports: [CoinsService],
})
export class CoinsModule {}
