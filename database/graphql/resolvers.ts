import { SoundsData } from '@/models/api'
import { PrismaClient } from '@prisma/client'
import { DateTimeResolver } from 'graphql-scalars'
const prisma = new PrismaClient()
//  Runtime config for use of environment variables in nuxt.config.ts

export default {
    DateTime: DateTimeResolver,
    Attendance: {
        attendee: async (parent: any) => {
            return await prisma.attendee.findUnique({
                where: {
                    id: parent.attendee_id
                }
            })
        },
        marathon: async (parent: any) => {
            return await prisma.marathon.findUnique({
                where: {
                    id: parent.marathon_id
                }
            })
        }
    },
    Attendee: {
        attendance: async (parent: any) => {
            return await prisma.attendance.findMany({
                where: {
                    attendee_id: parent.id
                }
            })
        },
        segments: async (parent: any) => {
            return await prisma.segment.findMany({
                where: {
                    segment_runner: {
                        some: {
                            attendee_id: parent.id
                        }
                    }
                }
            })
        }
    },
    Charity: {
        total: async (parent: any) => {
            const data = await prisma.marathon.aggregate({
                where: {
                    charity: parent.id
                },
                _sum: {
                    total: true
                }
            })
            return data._sum.total
        },
        marathons: async (parent: any) => {
            return await prisma.marathon.findMany({
                where: {
                    charity: parent.id
                }
            })
        }
    },
    Runner: {
        attendee: async (parent: any) => {
            return await prisma.attendee.findUnique({
                where: {
                    id: parent.attendee_id
                }
            })
        }
    },
    Game: {
        segments: async (parent: any) => {
            return await prisma.segment.findMany({
                where: {
                    game_id: parent.id
                }
            })
        }
    },
    Marathon: {
        segments: async (parent: any) => {
            return await prisma.segment.findMany({
                where: {
                    marathon_id: parent.id
                }
            })
        },
        segments_count: async (parent: any) => {
            return await prisma.segment.count({
                where: {
                    marathon_id: parent.id
                }
            })
        },
        charity: async (parent: any) => {
            return await prisma.charity.findUnique({
                where: {
                    id: parent.charity
                }
            })
        },
        attendance: async (parent: any) => {
            return await prisma.attendance.findMany({
                where: {
                    marathon_id: parent.id
                }
            })
        },
        attendance_count: async (parent: any) => {
            return await prisma.attendance.count({
                where: {
                    marathon_id: parent.id
                }
            })
        },
        donationsTime: async (parent: any) => {
            const res = await prisma.donations_over_time.findMany({
                where: {
                    marathon_id: parent.id
                }
            })
            return res
        }
    },
    Segment: {
        marathon: async (parent: any) => {
            return await prisma.marathon.findUnique({
                where: {
                    id: parent.marathon_id
                }
            })
        },
        game: async (parent: any) => {
            return await prisma.games.findUnique({
                where: {
                    id: parent.game_id
                }
            })
        },
        runners: async (parent: any) => {
            return await prisma.segment_runner.findMany({
                where: {
                    segment_id: parent.id
                }
            })
        },
        filenames: async (parent: any) => {
            return await prisma.segment_filename.findMany({
                where: {
                    segment_id: parent.id
                }
            })
        }
    },
    SoundsData: {
        sounds: async () => {
            return await prisma.sounds.findMany()
        }
    },
    Query: {
        tempsqhouseusers: async () => {
            return await prisma.sidequest_housechallenge.findMany()
        },
        tempsqhouses: async () => {
            return await prisma.sidequest_houseinfo.findMany()
        },
        attendees: async () => {
            return await prisma.attendee.findMany({
                include: {
                    attendance: true
                }
            })
        },
        attendee: async (_ctx: {}, { id }: { id: number }) => {
            return await prisma.attendee.findUnique({
                where: {
                    id: id
                }
            })
        },
        charities: async () => {
            return await prisma.charity.findMany()
        },
        charity: async (_ctx: {}, { id }: { id: number }) => {
            return await prisma.charity.findUnique({
                where: {
                    id: id
                }
            })
        },
        games: async () => {
            return await prisma.games.findMany()
        },
        game: async (_ctx: {}, { id }: { id: number }) => {
            return await prisma.games.findFirst({
                where: {
                    id: id
                }
            })
        },
        marathons: async () => {
            return await prisma.marathon.findMany()
        },
        marathon: async (_ctx: {}, { id }: { id: number }) => {
            return await prisma.marathon.findUnique({
                where: {
                    id: id
                }
            })
        },
        segment: async (_ctx: {}, { id }: { id: number }) => {
            return await prisma.segment.findUnique({
                where: {
                    id: id
                }
            })
        },
        segments: async (_ctx: {}, { method, id }: { method: string, id: number }) => {
            let methodConverted = {}
            switch(method) {
                case "marathon":
                    methodConverted = {marathon_id: id}
                    break
                case "game":
                    methodConverted = {game_id: id}
                    break
                case "runner":
                    methodConverted = {segment_runner: {some: {attendee_id: id}}}
                    break
            }
            return await prisma.segment.findMany({
                where: {
                    ...methodConverted,
                }
            })
        },
        sounds: async () => {
            return await prisma.sounds.findMany()
        },
        sound: async (_ctx: {}, { amount }: { amount: number }) => {
            return await prisma.sounds.findUnique({
                where: {
                    amount: amount
                }
            })
        },
        soundsdata: async () => {
            return await prisma.sounds_data.findMany()
        }
    },
    Mutation: {
        soundsdata: async (_ctx: {}, { soundsdata, key }: { soundsdata: SoundsData, key: string }) => {
            if(key != useRuntimeConfig().SOUNDS_KEY) return false
            await prisma.sounds_data.upsert({
                create: {
                    id: 1,
                    matching: soundsdata.matching ?? false,
                    updated: soundsdata.updated ?? new Date().toISOString()
                },
                update: {
                    matching: soundsdata.matching ?? false,
                    updated: soundsdata.updated ?? new Date().toISOString()
                },
                where: {
                    id: 1
                }
            })
            await prisma.sounds.deleteMany()
            await prisma.sounds.createMany({
                data: soundsdata.sounds
            })
            return true
        }
    }
}