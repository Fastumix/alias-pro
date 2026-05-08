import { ValidationPipe, VersioningType } from "@nestjs/common";
import { NestFactory } from "@nestjs/core";
import { DocumentBuilder, SwaggerModule } from "@nestjs/swagger";
import { AppModule } from "./app.module";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Global validation
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );

  // API versioning
  app.enableVersioning({ type: VersioningType.URI });

  // CORS — allow Flutter app (adjust origins in production)
  app.enableCors({
    origin: process.env.CORS_ORIGINS?.split(",") ?? "*",
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],
  });

  // Swagger UI at /api
  const config = new DocumentBuilder()
    .setTitle("Alias Pro API")
    .setDescription("REST API for Alias Pro mobile game")
    .setVersion("1.0")
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup("api", app, document);

  const port = process.env.PORT ?? 3000;
  await app.listen(port);
  console.log(`🚀 Server running on http://localhost:${port}`);
  console.log(`📖 Swagger docs at http://localhost:${port}/api`);
}

bootstrap();
