import { AfterViewInit, Component, ViewChild, OnInit } from '@angular/core';
import { MatSelectChange } from '@angular/material/select';
import { MatTableDataSource } from '@angular/material/table';
import { ActivatedRoute } from '@angular/router';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';

import { Classification } from 'src/app/models/Classification';
import { Mountain } from 'src/app/models/Mountain';
import { ClassificationsService } from 'src/app/services/classifications.service';

@Component({
  selector: 'app-classifications',
  templateUrl: './classifications.component.html',
  styleUrls: ['./classifications.component.css']
})
export class ClassificationsComponent implements OnInit, AfterViewInit {
  classifications: Classification[];
  selectedClassificationId: string;
  displayedColumns: string[] = ['name', 'height'];
  dataSource: MatTableDataSource<Mountain> = new MatTableDataSource<Mountain>([]);

  constructor(
    private route: ActivatedRoute,
    private classificationService: ClassificationsService) { }

  ngOnInit() {
    this.getClassifications();
  }
  
  @ViewChild(MatPaginator) paginator: MatPaginator;

  @ViewChild(MatSort) sort: MatSort;

  ngAfterViewInit() {
  }

  getClassifications(): void {
    this.classificationService
      .getClassifications()
      .subscribe(classifications => this.classifications = classifications);
  }

  onClassificationChange(event: MatSelectChange): void {
    this.dataSource = null;
    this.classificationService
      .getClassification(this.selectedClassificationId)
      .subscribe(classification => {
        this.dataSource = new MatTableDataSource<Mountain>(classification.mountains)
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      });
  }
}
