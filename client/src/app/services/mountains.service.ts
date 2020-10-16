import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Mountain } from '../Models/Mountain';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class MountainsService {

  private mountainsUrl = `${environment.apiBaseUrl}/mountains`;

  constructor(private http: HttpClient) { }

  getMountain(id: string): Observable<Mountain> {
    return this.http.get<Mountain>(`${this.mountainsUrl}/${id}`)
      .pipe(
        tap(_ => console.log(`fetched mountain id=${id}`)),
        catchError(this.handleError<Mountain>(`getMountain id=${id}`))
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
