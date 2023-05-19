import { Mountain } from './Mountain';

export interface Classification {
    id: string;

    name: string;

    displayOrder: number;

    description: string;

    mountains: Mountain[];
}
