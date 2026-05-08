import {
    Body,
    Controller,
    Get,
    Param,
    Post,
    Query,
    Request,
    UseGuards,
} from "@nestjs/common";
import { ApiBearerAuth, ApiQuery, ApiTags } from "@nestjs/swagger";
import { JwtAuthGuard } from "../auth/guards/jwt-auth.guard";
import { SaveGameResultDto } from "./dto/save-game-result.dto";
import { GamesService } from "./games.service";

@ApiTags("games")
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller({ path: "games", version: "1" })
export class GamesController {
  constructor(private readonly gamesService: GamesService) {}

  @Post("results")
  saveResult(
    @Request() req: { user: { id: string } },
    @Body() dto: SaveGameResultDto,
  ) {
    return this.gamesService.saveResult(req.user.id, dto);
  }

  @Get("results")
  myResults(@Request() req: { user: { id: string } }) {
    return this.gamesService.findUserResults(req.user.id);
  }

  @Get("results/:id")
  getResult(@Param("id") id: string) {
    return this.gamesService.findOne(id);
  }

  @ApiQuery({ name: "limit", required: false, type: Number })
  @Get("words/:categorySlug")
  getWords(
    @Param("categorySlug") slug: string,
    @Query("limit") limit?: number,
  ) {
    return this.gamesService.getWords(slug, limit);
  }
}
