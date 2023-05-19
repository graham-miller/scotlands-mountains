import { Classification } from './Classification';
import { County } from './County';
import { Section } from './Section';
import { Map } from './Map';

export class Mountain {
    id: string;
    name: string;
    aliases: string[];
    section: Section;
    classifications: Classification[];
    height: number;
    latitude: number;
    longitude: number;
    gridRef: string;
    prominence: {
        height: number,
        from: string,
        fromHeight: number
    };
    summit: {
        description: string,
        notes: string
    };
    island: string;
    county: County;
    maps: Map[];
}