export type TempSideQuestHouse = {
  id: string;
  name: string;
  color: string;
  score?: number;
};

export type TempSideQuestHouseUser = {
  id: string;
  name: string;
  house_id: number;
};

export type Attendance = {
  attendee: Attendee;
  marathon: Marathon;
  award?: string;
  location?: string;
};

export type Attendee = {
  id: string;
  name: string;
  rank: string;
  house?: string;
  house_color?: string;
  twitch_login?: string;
  segments: Segment[];
  attendance?: Attendance[];
};

export type DonationsOverTime = {
  marathon_id: number;
  hour: string;
  total: number;
};

export type Runner = {
  attendee: Attendee;
  rank: number;
};

export type Game = {
  id: string;
  title: string;
  segments: Segment[];
  iszelda?: boolean;
  isevent?: boolean;
};

export type Charity = {
  id: string;
  slug: string;
  full_name: string;
  website: string;
  total: number;
  marathons: Marathon[];
};

export type Marathon = {
  id: string;
  type: string;
  type_id: number;
  slug: string;
  full_name: string;
  total: number;
  start_date: string;
  stop_date: string;
  playlist: string;
  charity: Charity;
  color: string;
  segments: Segment[];
  segments_count?: number;
  runners: Runner[];
  attendance?: Attendance[];
  attendance_count?: number;
  donationsTime: DonationsOverTime[];
};

export type Filename = {
  segment_id: string;
  filename: string;
  note: string;
};

export type Segment = {
  id: string;
  marathon?: Marathon;
  game?: Game;
  modifier?: string;
  raised?: number;
  start_time: string;
  end_time: string;
  vod: string;
  time_offset: number;
  runners: Runner[];
  filenames: Filename[];
};

export type SoundsData = {
  updated: string;
  matching: boolean;
  sounds: Sound[];
};

export type Sound = {
  amount: string;
  description: string;
  verified: boolean;
  newsound: boolean;
  matched: boolean;
};
