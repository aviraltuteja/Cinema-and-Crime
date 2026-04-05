-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "vector";

-- CreateExtension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- CreateTable
CREATE TABLE "State" (
    "code" VARCHAR(5) NOT NULL,
    "name" TEXT NOT NULL,
    "region" VARCHAR(50),
    "population" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "State_pkey" PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "Film" (
    "id" SERIAL NOT NULL,
    "tmdbId" INTEGER,
    "imdbId" VARCHAR(20),
    "title" TEXT NOT NULL,
    "originalTitle" TEXT,
    "releaseDate" DATE NOT NULL,
    "year" INTEGER NOT NULL,
    "language" VARCHAR(10) NOT NULL,
    "originalLanguage" VARCHAR(10),
    "synopsis" TEXT,
    "genres" JSONB,
    "keywords" JSONB,
    "revenueDomesticCr" DECIMAL(12,2),
    "revenueWorldwideCr" DECIMAL(12,2),
    "budgetCr" DECIMAL(12,2),
    "openingWeekendCr" DECIMAL(12,2),
    "popularity" DOUBLE PRECISION,
    "voteAverage" DOUBLE PRECISION,
    "voteCount" INTEGER,
    "runtime" INTEGER,
    "screensCount" INTEGER,
    "releaseWeek" INTEGER,
    "sequel" BOOLEAN NOT NULL DEFAULT false,
    "starPowerIndex" DOUBLE PRECISION,
    "certification" VARCHAR(10),
    "productionCompanies" JSONB,
    "cast" JSONB,
    "crew" JSONB,
    "posterPath" TEXT,
    "backdropPath" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Film_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BoxOfficeWeek" (
    "id" SERIAL NOT NULL,
    "filmId" INTEGER NOT NULL,
    "weekNumber" INTEGER NOT NULL,
    "collectionCr" DECIMAL(12,2) NOT NULL,
    "cumulativeCr" DECIMAL(12,2),
    "weekStart" DATE NOT NULL,
    "weekEnd" DATE NOT NULL,
    "source" VARCHAR(100),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "BoxOfficeWeek_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FilmAnnotation" (
    "id" SERIAL NOT NULL,
    "filmId" INTEGER NOT NULL,
    "protagonistName" TEXT,
    "protagonistGender" VARCHAR(20),
    "protagonistReligion" VARCHAR(50),
    "protagonistCaste" VARCHAR(50),
    "protagonistProfession" TEXT,
    "protagonistEconomicClass" VARCHAR(30),
    "protagonistAge" VARCHAR(20),
    "protagonistBreaksLaw" BOOLEAN,
    "violenceGlorified" BOOLEAN,
    "crimeAsNecessity" BOOLEAN,
    "revengeNarrative" BOOLEAN,
    "antiAuthorityTheme" BOOLEAN,
    "vigilanteJustice" BOOLEAN,
    "genrePrimary" VARCHAR(50),
    "genreSecondary" VARCHAR(50),
    "tone" VARCHAR(30),
    "settingUrbanRural" VARCHAR(20),
    "eraDepicted" VARCHAR(30),
    "crimesShown" JSONB,
    "crimeTypePrimary" VARCHAR(50),
    "crimeRewarded" BOOLEAN,
    "policePortrayedAs" VARCHAR(30),
    "crimeScreenTimePct" DOUBLE PRECISION,
    "communalTension" BOOLEAN,
    "classConflict" BOOLEAN,
    "genderDynamics" VARCHAR(50),
    "romanticViolenceNormalized" BOOLEAN,
    "casteDiscrimination" BOOLEAN,
    "ruralUrbanMigration" BOOLEAN,
    "protagonistFate" VARCHAR(30),
    "moralLessonExplicit" BOOLEAN,
    "justiceServed" BOOLEAN,
    "annotationSource" VARCHAR(30),
    "confidenceScore" DOUBLE PRECISION,
    "isGoldStandard" BOOLEAN NOT NULL DEFAULT false,
    "reviewedBy" TEXT,
    "annotatedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "FilmAnnotation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CrimeRecord" (
    "id" SERIAL NOT NULL,
    "stateCode" VARCHAR(5) NOT NULL,
    "city" VARCHAR(100),
    "district" VARCHAR(100),
    "crimeType" TEXT NOT NULL,
    "crimeCategory" VARCHAR(50),
    "ipcSection" VARCHAR(30),
    "casesRegistered" INTEGER NOT NULL,
    "casesChargesheeted" INTEGER,
    "casesConvicted" INTEGER,
    "casesAcquitted" INTEGER,
    "year" INTEGER NOT NULL,
    "month" INTEGER,
    "week" INTEGER,
    "populationEstimate" INTEGER,
    "crimeRatePerLakh" DOUBLE PRECISION,
    "source" VARCHAR(100),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CrimeRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AnalysisWindow" (
    "id" SERIAL NOT NULL,
    "filmId" INTEGER NOT NULL,
    "stateCode" VARCHAR(5) NOT NULL,
    "crimeType" TEXT NOT NULL,
    "windowStart" DATE NOT NULL,
    "windowEnd" DATE NOT NULL,
    "windowWeeks" INTEGER NOT NULL DEFAULT 4,
    "baselineRate" DOUBLE PRECISION NOT NULL,
    "observedRate" DOUBLE PRECISION NOT NULL,
    "delta" DOUBLE PRECISION NOT NULL,
    "deltaPercent" DOUBLE PRECISION,
    "zScore" DOUBLE PRECISION NOT NULL,
    "pValue" DOUBLE PRECISION,
    "effectSize" DOUBLE PRECISION,
    "ciLower" DOUBLE PRECISION,
    "ciUpper" DOUBLE PRECISION,
    "controlsApplied" JSONB,
    "methodology" VARCHAR(50),
    "isSignificant" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AnalysisWindow_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FilmEmbedding" (
    "id" SERIAL NOT NULL,
    "filmId" INTEGER NOT NULL,
    "chunkText" TEXT NOT NULL,
    "chunkType" VARCHAR(30) NOT NULL,
    "embedding" vector(1536),
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FilmEmbedding_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ConfoundData" (
    "id" SERIAL NOT NULL,
    "stateCode" VARCHAR(5) NOT NULL,
    "year" INTEGER NOT NULL,
    "month" INTEGER,
    "festivalActive" BOOLEAN,
    "festivalName" VARCHAR(50),
    "electionPeriod" BOOLEAN,
    "unemploymentRate" DOUBLE PRECISION,
    "avgTemperature" DOUBLE PRECISION,
    "rainfallMm" DOUBLE PRECISION,
    "gdpPerCapita" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ConfoundData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DataSource" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT,
    "dataType" VARCHAR(30) NOT NULL,
    "lastFetchedAt" TIMESTAMP(3),
    "recordCount" INTEGER,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DataSource_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "State_name_key" ON "State"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Film_tmdbId_key" ON "Film"("tmdbId");

-- CreateIndex
CREATE UNIQUE INDEX "Film_imdbId_key" ON "Film"("imdbId");

-- CreateIndex
CREATE INDEX "Film_year_idx" ON "Film"("year");

-- CreateIndex
CREATE INDEX "Film_language_idx" ON "Film"("language");

-- CreateIndex
CREATE INDEX "Film_releaseDate_idx" ON "Film"("releaseDate");

-- CreateIndex
CREATE UNIQUE INDEX "BoxOfficeWeek_filmId_weekNumber_key" ON "BoxOfficeWeek"("filmId", "weekNumber");

-- CreateIndex
CREATE UNIQUE INDEX "FilmAnnotation_filmId_key" ON "FilmAnnotation"("filmId");

-- CreateIndex
CREATE INDEX "CrimeRecord_stateCode_year_idx" ON "CrimeRecord"("stateCode", "year");

-- CreateIndex
CREATE INDEX "CrimeRecord_crimeType_idx" ON "CrimeRecord"("crimeType");

-- CreateIndex
CREATE INDEX "CrimeRecord_year_month_idx" ON "CrimeRecord"("year", "month");

-- CreateIndex
CREATE INDEX "AnalysisWindow_stateCode_idx" ON "AnalysisWindow"("stateCode");

-- CreateIndex
CREATE INDEX "AnalysisWindow_crimeType_idx" ON "AnalysisWindow"("crimeType");

-- CreateIndex
CREATE UNIQUE INDEX "AnalysisWindow_filmId_stateCode_crimeType_windowWeeks_key" ON "AnalysisWindow"("filmId", "stateCode", "crimeType", "windowWeeks");

-- CreateIndex
CREATE INDEX "FilmEmbedding_filmId_idx" ON "FilmEmbedding"("filmId");

-- CreateIndex
CREATE UNIQUE INDEX "ConfoundData_stateCode_year_month_key" ON "ConfoundData"("stateCode", "year", "month");

-- CreateIndex
CREATE UNIQUE INDEX "DataSource_name_key" ON "DataSource"("name");

-- AddForeignKey
ALTER TABLE "BoxOfficeWeek" ADD CONSTRAINT "BoxOfficeWeek_filmId_fkey" FOREIGN KEY ("filmId") REFERENCES "Film"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FilmAnnotation" ADD CONSTRAINT "FilmAnnotation_filmId_fkey" FOREIGN KEY ("filmId") REFERENCES "Film"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CrimeRecord" ADD CONSTRAINT "CrimeRecord_stateCode_fkey" FOREIGN KEY ("stateCode") REFERENCES "State"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnalysisWindow" ADD CONSTRAINT "AnalysisWindow_filmId_fkey" FOREIGN KEY ("filmId") REFERENCES "Film"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AnalysisWindow" ADD CONSTRAINT "AnalysisWindow_stateCode_fkey" FOREIGN KEY ("stateCode") REFERENCES "State"("code") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FilmEmbedding" ADD CONSTRAINT "FilmEmbedding_filmId_fkey" FOREIGN KEY ("filmId") REFERENCES "Film"("id") ON DELETE CASCADE ON UPDATE CASCADE;
