import { ApiPropertyOptional } from "@nestjs/swagger";
import { IsEmail, IsOptional, IsString, MinLength } from "class-validator";

export class CreateUserDto {
  @ApiPropertyOptional()
  @IsEmail()
  @IsOptional()
  email?: string;

  @ApiPropertyOptional()
  @IsString()
  @MinLength(8)
  @IsOptional()
  passwordHash?: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  displayName?: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  avatarEmoji?: string;

  @ApiPropertyOptional()
  @IsString()
  @IsOptional()
  firebaseUid?: string;

  @IsOptional()
  isAnonymous?: boolean;
}
