import { Classification } from "./Classification";

export interface Mountain {
    id: string;
    position?: number;
    name: string;
    aliases?: string[];
    location: Location;
    dobihId?: number;
    gridRef?: string;
    height: Height;
    prominence?: Prominence;
    features?: string;
    observations?: string;
    parent?: Mountain;
    region?: Region;
    county?: County;
    classifications?: Classification[];
    maps?: Map[];
}

export interface Location {
    type: string;
    coordinates: number[];
}

export interface Height {
    metres: number;
}

export interface Prominence
{
    metres: number;
    measuredFrom: string;
    measuredFromHeight: Height;
}

export interface Region {
    id: string;
    name: string;
}

export interface County {
    id: string;
    name: string;
}

export interface Map {
    id: string;
    code: string;
    scale: number;
}