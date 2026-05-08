import {
    BadRequestException,
    Injectable,
    UnauthorizedException,
} from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import * as bcrypt from "bcrypt";
import { UsersService } from "../users/users.service";
import { LoginDto } from "./dto/login.dto";
import { RegisterDto } from "./dto/register.dto";
import { JwtPayload } from "./strategies/jwt.strategy";

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async register(dto: RegisterDto) {
    const existing = await this.usersService.findByEmail(dto.email);
    if (existing) throw new BadRequestException("Email already in use");

    const passwordHash = await bcrypt.hash(dto.password, 12);
    const user = await this.usersService.create({
      email: dto.email,
      passwordHash,
      displayName: dto.displayName,
    });

    return this.issueToken(user.id, user.email);
  }

  async login(dto: LoginDto) {
    const user = await this.usersService.findByEmail(dto.email);
    if (!user || !user.passwordHash)
      throw new UnauthorizedException("Invalid credentials");

    const valid = await bcrypt.compare(dto.password, user.passwordHash);
    if (!valid) throw new UnauthorizedException("Invalid credentials");

    return this.issueToken(user.id, user.email);
  }

  /** Sign in / register with a Firebase ID token (anonymous or Google). */
  async firebaseAuth(firebaseUid: string, email: string | null) {
    let user = await this.usersService.findByFirebaseUid(firebaseUid);
    if (!user) {
      user = await this.usersService.create({
        firebaseUid,
        email: email ?? undefined,
        displayName: email?.split("@")[0] ?? "Player",
        isAnonymous: !email,
      });
    }
    return this.issueToken(user.id, user.email);
  }

  private issueToken(userId: string, email: string | null) {
    const payload: JwtPayload = { sub: userId, email };
    return {
      accessToken: this.jwtService.sign(payload),
      userId,
    };
  }
}
