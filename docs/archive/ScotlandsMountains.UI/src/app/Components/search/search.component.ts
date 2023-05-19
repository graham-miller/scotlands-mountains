import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { fromEvent } from 'rxjs';
import { debounceTime, distinctUntilChanged, filter, map } from 'rxjs/operators';
import { SearchResult } from 'src/app/Models/SearchResult';
import { MountainDataService } from 'src/app/Services/MountainDataService';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.scss']
})
export class SearchComponent implements OnInit {

  @ViewChild('search', { static: true }) searchInput?: ElementRef;

  searchTerm: string = '';
  searchResult?: SearchResult;
  searchResultColumns = ['name', 'height'];

  constructor(
    private mountainDataService: MountainDataService
  ) { }

  ngOnInit(): void {
    fromEvent(this.searchInput?.nativeElement, 'keyup').pipe(
      map((event: any) => event.target.value),
      debounceTime(300),
      distinctUntilChanged()
    ).subscribe(term => this.search(term));
  }

  search(term?: string) {
    if (term && term.length > 2) {
      this.mountainDataService.search(term).subscribe(searchResult => {
        this.searchResult = searchResult;
      });
    } else {
      this.searchResult = undefined;
    }
  }

  loadMore() {
    if (this.searchResult) {
      const body = JSON.stringify({continuationToken: this.searchResult.continuationToken});
      this.mountainDataService.search(this.searchResult.term, body).subscribe(searchResult => {
        if (this.searchResult) {
          searchResult.results = this.searchResult.results.concat(searchResult.results);
        }
        this.searchResult = searchResult;
      });
    }
  }

  clear() {
    (<any>this.searchInput?.nativeElement).focus();
    this.searchTerm = '';
    this.searchResult = undefined;
  }
}
