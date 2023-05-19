import { Mountain } from "./Mountain"

export interface SearchResult {
    term: string;
    continuationToken?: string;
    results: Mountain[];
}