import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Classification } from '../models/Classification';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ClassificationsService {

  private classificationsUrl = `${environment.apiBaseUrl}/classifications`;

  constructor(private http: HttpClient) { }

  getClassifications(): Observable<Classification[]> {
    return this.http.get<Classification[]>(this.classificationsUrl)
      .pipe(
        tap(_ => console.log('fetched classifications')),
        catchError(this.handleError<Classification[]>('getClassifications', []))
      );
  }

  getClassification(id: string): Observable<Classification> {
    return this.http.get<Classification>(`${this.classificationsUrl}/${id}`)
      .pipe(
        tap(_ => console.log(`fetched classifications id=${id}`)),
        catchError(this.handleError<Classification>(`getClassification id=${id}`))
      );
  }

  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
  
      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead
  
      // TODO: better job of transforming error for user consumption
      //this.log(`${operation} failed: ${error.message}`);
  
      // Let the app keep running by returning an empty result.
      return of(result as T);
    };  
  }
}
