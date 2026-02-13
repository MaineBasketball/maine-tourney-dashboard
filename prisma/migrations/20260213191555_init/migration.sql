-- CreateTable
CREATE TABLE "Game" (
    "id" TEXT NOT NULL,
    "source" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "className" TEXT NOT NULL,
    "region" TEXT,
    "round" TEXT,
    "venue" TEXT,
    "city" TEXT,
    "startTime" TIMESTAMP(3),
    "homeTeam" TEXT,
    "awayTeam" TEXT,
    "homeSeed" INTEGER,
    "awaySeed" INTEGER,
    "status" TEXT NOT NULL DEFAULT 'scheduled',
    "fingerprint" TEXT NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Game_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChangeEvent" (
    "id" TEXT NOT NULL,
    "gameId" TEXT,
    "gender" TEXT NOT NULL,
    "className" TEXT NOT NULL,
    "venue" TEXT,
    "summary" TEXT NOT NULL,
    "before" JSONB,
    "after" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ChangeEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Subscriber" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Subscriber_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Game_gender_className_idx" ON "Game"("gender", "className");

-- CreateIndex
CREATE INDEX "Game_venue_idx" ON "Game"("venue");

-- CreateIndex
CREATE INDEX "Game_startTime_idx" ON "Game"("startTime");

-- CreateIndex
CREATE INDEX "ChangeEvent_createdAt_idx" ON "ChangeEvent"("createdAt");

-- CreateIndex
CREATE INDEX "ChangeEvent_venue_idx" ON "ChangeEvent"("venue");
