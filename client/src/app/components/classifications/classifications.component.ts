import { Component, ViewChild, OnInit } from '@angular/core';
import { Router } from '@angular/router';
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
export class ClassificationsComponent implements OnInit {
  all: Classification[];
  id: string;
  columns: string[] = ['name', 'height'];
  mountains: MatTableDataSource<Mountain>;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private classificationService: ClassificationsService) { }

  ngOnInit() {
    this.getClassifications();
    this.route.params.subscribe(route => {
      this.id = route.id
      this.getClassification()
    });
  }

  @ViewChild(MatPaginator) paginator: MatPaginator;

  @ViewChild(MatSort) sort: MatSort;

  getClassifications(): void {
    this.classificationService
      .getClassifications()
      .subscribe(c => this.all = c);
  }

  getClassification() {
    if (this.id) {
      this.classificationService
        .getClassification(this.id)
        .subscribe(c => {
          this.mountains = new MatTableDataSource<Mountain>(c.mountains);
          this.mountains.paginator = this.paginator;
          this.mountains.sort = this.sort;
        });
    }
  }

  onClassificationChange(event: MatSelectChange): void {
    this.mountains = null;
    const command = [(this.route.snapshot.paramMap.get('id') ? '../' : '') + this.id];
    this.router.navigate(command, { relativeTo: this.route });
  }
}
