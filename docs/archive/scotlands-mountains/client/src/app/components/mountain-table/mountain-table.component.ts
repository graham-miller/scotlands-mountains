import { Component, ViewChild, Input, OnInit } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Mountain } from 'src/app/models/Mountain';

@Component({
  selector: 'app-mountain-table',
  templateUrl: './mountain-table.component.html',
  styleUrls: ['./mountain-table.component.css']
})
export class MountainTableComponent {
  columns: string[] = ['name', 'height'];
  rows: MatTableDataSource<Mountain>;

  @ViewChild(MatPaginator) paginator: MatPaginator;

  @ViewChild(MatSort) sort: MatSort;

  @Input()
  set mountains(mountains: Mountain[]){
    if (mountains) {
      this.rows = new MatTableDataSource<Mountain>(mountains);
      this.rows.paginator = this.paginator;
      this.rows.sort = this.sort;
    } else {
      this.rows = null;
    }
  }
}
