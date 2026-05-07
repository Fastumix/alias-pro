import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CoinTransaction } from './coin-transaction.entity';
import { User } from '../users/user.entity';
import { CoinsService } from './coins.service';
import { CoinsController } from './coins.controller';

@Module({
  imports: [TypeOrmModule.forFeature([CoinTransaction, User])],
  providers: [CoinsService],
  controllers: [CoinsController],
  exports: [CoinsService],
})
export class CoinsModule {}
