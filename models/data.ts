export type SortOption<T> = {
  name: string;
  value: string;
  icon: string;
  sort: (a: T, b: T) => number;
};
export type FilterOption<T> = {
  name: string;
  value: string;
  icon: string;
  filter: (a: T) => boolean;
};
