import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Classification } from '../Models/Classification';
import { InitialData } from '../Models/InitialData';
import { Mountain } from '../Models/Mountain';
import { SearchResult } from '../Models/SearchResult';

@Injectable({
    providedIn: 'root'
})
export class MountainDataService {
    constructor(private http: HttpClient) {
    }

    getInitialData(): Observable<InitialData> {
        return this.http.get<InitialData>('http://localhost:7071/api/initial')
            .pipe(catchError(this.handleError<InitialData>('getInitialData()')))
    }

    getClassifications(): Observable<Classification[]> {
        return this.http.get<Classification[]>(`http://localhost:7071/api/classifications`)
            .pipe(catchError(this.handleError<Classification[]>('getClassifications()')))
    }

    getClassification(id: string): Observable<Classification> {
        return this.http.get<Classification>(`http://localhost:7071/api/classifications/${id}`)
            .pipe(catchError(this.handleError<Classification>(`getClassification(${id})`)))
    }

    getMountain(id: string): Observable<Mountain> {
        return this.http.get<Mountain>(`http://localhost:7071/api/mountains/${id}`)
            .pipe(catchError(this.handleError<Mountain>(`getMountain(${id})`)))
    }

    search(term: string, continuationToken?: string) {
        if (continuationToken) {
            return this.http.post<SearchResult>(`http://localhost:7071/api/search?term=${encodeURIComponent(term)}`, continuationToken)
            .pipe(catchError(this.handleError<SearchResult>(`search(${term})`)))
        } else {
            return this.http.get<SearchResult>(`http://localhost:7071/api/search?term=${encodeURIComponent(term)}`)
            .pipe(catchError(this.handleError<SearchResult>(`search(${term})`)))
        }
    }

    private handleError<T>(operation = 'operation', result?: T) {
        return (error: any): Observable<T> => {
            console.error(operation, error);
            return of(result as T);
        }
    }
}