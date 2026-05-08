import { ApiProperty, ApiPropertyOptional } from "@nestjs/swagger";
import { IsInt, IsNotEmpty, IsOptional, IsString, Min } from "class-validator";

export class SaveGameResultDto {
  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  categorySlug: string;

  @ApiProperty()
  @IsString()
  @IsNotEmpty()
  teamName: string;

  @ApiProperty()
  @IsInt()
  @Min(1)
  round: number;

  @ApiProperty()
  @IsInt()
  @Min(0)
  score: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(0)
  correctCount?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(0)
  skipCount?: number;

  @ApiPropertyOptional()
  @IsOptional()
  @IsInt()
  @Min(10)
  timeRound?: number;
}
