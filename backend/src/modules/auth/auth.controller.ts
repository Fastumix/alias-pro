import { Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';

@ApiTags('auth')
@Controller({ path: 'auth', version: '1' })
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  register(@Body() dto: RegisterDto) {
    return this.authService.register(dto);
  }

  @Post('login')
  login(@Body() dto: LoginDto) {
    return this.authService.login(dto);
  }

  /**
   * Exchange a Firebase ID token for an app JWT.
   * The Flutter client sends the Firebase token; the server verifies it
   * and returns an app-issued JWT.
   * NOTE: full Firebase Admin SDK verification can be wired in later.
   */
  @Post('firebase')
  async firebaseLogin(
    @Body('firebaseUid') firebaseUid: string,
    @Body('email') email?: string,
  ) {
    return this.authService.firebaseAuth(firebaseUid, email ?? null);
  }
}
