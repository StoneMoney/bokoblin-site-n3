-- CreateTable
CREATE TABLE `TestDb` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `boolean_thing` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attendance` (
    `attendee_id` INTEGER NOT NULL,
    `marathon_id` INTEGER NOT NULL,
    `award` VARCHAR(300) NULL,
    `location` VARCHAR(45) NULL DEFAULT '1',

    INDEX `fk_marathon2`(`marathon_id`),
    PRIMARY KEY (`attendee_id`, `marathon_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attendee` (
    `id` INTEGER NOT NULL,
    `kinstone_id` INTEGER NULL,
    `name` VARCHAR(250) NOT NULL,
    `alias` VARCHAR(250) NULL,
    `twitch_login` VARCHAR(50) NOT NULL,
    `rank` INTEGER NOT NULL DEFAULT 1,
    `house` INTEGER NOT NULL DEFAULT 0,

    INDEX `fk_house`(`house`),
    INDEX `fk_rank`(`rank`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attendee_rank` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(16) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `charity` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `slug` VARCHAR(50) NOT NULL,
    `full_name` VARCHAR(150) NOT NULL,
    `website` VARCHAR(250) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `donations_over_time` (
    `marathon_id` INTEGER NOT NULL,
    `hours` DECIMAL(5, 1) NOT NULL,
    `total` DECIMAL(8, 2) NOT NULL,

    PRIMARY KEY (`marathon_id`, `hours`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `games` (
    `id` INTEGER NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `isZelda` BOOLEAN NOT NULL,
    `isEvent` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `house` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(40) NOT NULL,
    `color` VARCHAR(6) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jamtrain_reacts` (
    `request_id` INTEGER NOT NULL,
    `react_id` INTEGER NOT NULL,
    `user` VARCHAR(35) NOT NULL,

    PRIMARY KEY (`request_id`, `react_id`, `user`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `jamtrain_requests` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `string` VARCHAR(200) NOT NULL,
    `href` TEXT NOT NULL,
    `room` VARCHAR(5) NOT NULL,
    `status` VARCHAR(15) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `logins` (
    `id` INTEGER NOT NULL,
    `access_token` VARCHAR(250) NOT NULL,
    `refresh_token` VARCHAR(250) NOT NULL,
    `expiration` INTEGER NOT NULL,
    `slug` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `logins_example` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(40) NOT NULL,
    `password` VARCHAR(200) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `marathon` (
    `id` INTEGER NOT NULL,
    `type` INTEGER NOT NULL,
    `slug` VARCHAR(50) NOT NULL,
    `full_name` VARCHAR(200) NOT NULL,
    `total` DECIMAL(10, 2) NOT NULL,
    `start_date` DATETIME(0) NOT NULL,
    `stop_date` DATETIME(0) NOT NULL,
    `playlist` VARCHAR(90) NULL,
    `charity` INTEGER NOT NULL,
    `color` VARCHAR(6) NOT NULL,

    INDEX `fk_charity`(`charity`),
    INDEX `fk_type`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `marathon_type` (
    `id` INTEGER NOT NULL,
    `title` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `runner_rank` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sort_id` INTEGER NOT NULL,
    `title` VARCHAR(40) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `segment` (
    `id` INTEGER NOT NULL,
    `marathon_id` INTEGER NOT NULL,
    `game_id` INTEGER NOT NULL,
    `modifier` VARCHAR(250) NULL,
    `raised` DECIMAL(9, 2) NOT NULL DEFAULT 0.00,
    `start_time` DATETIME(0) NOT NULL,
    `end_time` DATETIME(0) NOT NULL,
    `vod` VARCHAR(25) NULL,
    `time_offset` INTEGER NULL,

    INDEX `fk_game`(`game_id`),
    INDEX `fk_marathon`(`marathon_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `segment_filename` (
    `segment_id` INTEGER NOT NULL,
    `filename` VARCHAR(40) NOT NULL,
    `note` VARCHAR(120) NULL,

    PRIMARY KEY (`segment_id`, `filename`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `segment_runner` (
    `segment_id` INTEGER NOT NULL,
    `attendee_id` INTEGER NOT NULL,
    `rank` INTEGER NOT NULL DEFAULT 0,

    INDEX `fk_attendie`(`attendee_id`),
    INDEX `fk_runnerrank`(`rank`),
    PRIMARY KEY (`segment_id`, `attendee_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sidequest_housechallenge` (
    `id` INTEGER NOT NULL,
    `access_token` VARCHAR(250) NOT NULL,
    `refresh_token` VARCHAR(250) NOT NULL,
    `expiration` INTEGER NOT NULL,
    `slug` VARCHAR(40) NOT NULL,
    `house` INTEGER NOT NULL,
    `decided_time` DATETIME(0) NULL,

    INDEX `fk_sqhouse`(`house`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sidequest_houseinfo` (
    `id` INTEGER NOT NULL,
    `name` VARCHAR(9) NOT NULL,
    `color` VARCHAR(6) NOT NULL,
    `score` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sidequest_housetransaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `amount` INTEGER NOT NULL,
    `team` INTEGER NOT NULL,
    `reason` TEXT NOT NULL,

    INDEX `fk_team`(`team`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sounds` (
    `amount` INTEGER NOT NULL,
    `description` TEXT NULL,
    `isVerified` BOOLEAN NULL DEFAULT false,
    `isNew` BOOLEAN NULL DEFAULT false,
    `isMatched` BOOLEAN NULL DEFAULT false,

    PRIMARY KEY (`amount`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sounds_data` (
    `id` INTEGER NOT NULL,
    `last_updated` DATETIME(0) NOT NULL,
    `isMatching` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `temp_channel_list` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `twitch` VARCHAR(90) NOT NULL,
    `rebroadcast` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `temp_stjude_videos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `video` VARCHAR(15) NOT NULL,
    `playcount` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `attendance` ADD CONSTRAINT `fk_attendee1` FOREIGN KEY (`attendee_id`) REFERENCES `attendee`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `attendance` ADD CONSTRAINT `fk_marathon2` FOREIGN KEY (`marathon_id`) REFERENCES `marathon`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `attendee` ADD CONSTRAINT `fk_house` FOREIGN KEY (`house`) REFERENCES `house`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `attendee` ADD CONSTRAINT `fk_rank` FOREIGN KEY (`rank`) REFERENCES `attendee_rank`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `donations_over_time` ADD CONSTRAINT `fk_marathondot` FOREIGN KEY (`marathon_id`) REFERENCES `marathon`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `jamtrain_reacts` ADD CONSTRAINT `req` FOREIGN KEY (`request_id`) REFERENCES `jamtrain_requests`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `marathon` ADD CONSTRAINT `fk_charity` FOREIGN KEY (`charity`) REFERENCES `charity`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `marathon` ADD CONSTRAINT `fk_type` FOREIGN KEY (`type`) REFERENCES `marathon_type`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `segment` ADD CONSTRAINT `fk_game` FOREIGN KEY (`game_id`) REFERENCES `games`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `segment` ADD CONSTRAINT `fk_marathon` FOREIGN KEY (`marathon_id`) REFERENCES `marathon`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `segment_filename` ADD CONSTRAINT `fk_segment2` FOREIGN KEY (`segment_id`) REFERENCES `segment`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `segment_runner` ADD CONSTRAINT `fk_attendie` FOREIGN KEY (`attendee_id`) REFERENCES `attendee`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `segment_runner` ADD CONSTRAINT `fk_runnerrank` FOREIGN KEY (`rank`) REFERENCES `runner_rank`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `segment_runner` ADD CONSTRAINT `fk_segment` FOREIGN KEY (`segment_id`) REFERENCES `segment`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sidequest_housechallenge` ADD CONSTRAINT `fk_sqhouse` FOREIGN KEY (`house`) REFERENCES `sidequest_houseinfo`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `sidequest_housetransaction` ADD CONSTRAINT `fk_team` FOREIGN KEY (`team`) REFERENCES `sidequest_houseinfo`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

