import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css']
})
export class SearchComponent implements OnInit {
  term: string = '';

  constructor() { }

  ngOnInit(): void {
  }

  onTermChange(term) {
    this.term = term;
  }
}
