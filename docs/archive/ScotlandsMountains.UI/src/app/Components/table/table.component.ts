import { AfterViewInit, Component, Input, OnChanges, ViewChild } from '@angular/core';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { Mountain } from 'src/app/Models/Mountain';

@Component({
  selector: 'app-table',
  templateUrl: './table.component.html',
  styleUrls: ['./table.component.scss']
})
export class TableComponent implements AfterViewInit, OnChanges {
  columns: string[] = ['position', 'name', 'height'];
  dataSource: MatTableDataSource<Mountain> = new MatTableDataSource<Mountain>([]);

  @ViewChild(MatPaginator) paginator?: MatPaginator = undefined;
  @ViewChild(MatSort) sort?: MatSort = undefined;

  @Input() mountains: Mountain[] = [];

  ngAfterViewInit(): void {
    this.displayMountains();
  }

  ngOnChanges(): void {
    this.displayMountains();
  }

  private displayMountains() {
    if (this.mountains) {
      this.dataSource = new MatTableDataSource<Mountain>(this.mountains);

      if (this.paginator && this.sort){
        this.dataSource.paginator = this.paginator;
        this.dataSource.sortingDataAccessor = this.getSortingDataAccessor;        
        this.dataSource.sort = this.sort;
      }
    }
  }

  private getSortingDataAccessor(mountain: Mountain, property: string): string | number {
    switch(property) {
      case 'position': return mountain.position ?? 0;
      case 'height': return mountain.height.metres;
      case 'name': return mountain.name;
      default: return 0;
    }
  }
}
