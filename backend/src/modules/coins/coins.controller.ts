import { Controller, Get, Request, UseGuards } from "@nestjs/common";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { JwtAuthGuard } from "../auth/guards/jwt-auth.guard";
import { CoinsService } from "./coins.service";

@ApiTags("coins")
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller({ path: "coins", version: "1" })
export class CoinsController {
  constructor(private readonly coinsService: CoinsService) {}

  @Get("balance")
  balance(@Request() req: { user: { id: string } }) {
    return this.coinsService.getBalance(req.user.id);
  }

  @Get("history")
  history(@Request() req: { user: { id: string } }) {
    return this.coinsService.getHistory(req.user.id);
  }
}
