import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, ParamMap } from '@angular/router';

import { Classification } from 'src/app/models/Classification';
import { ClassificationsService } from 'src/app/services/classifications.service';

@Component({
  selector: 'app-classifications',
  templateUrl: './classifications.component.html',
  styleUrls: ['./classifications.component.css']
})
export class ClassificationsComponent implements OnInit {
  classifications: Classification[];

  constructor(
    private route: ActivatedRoute,
    private classificationService: ClassificationsService)
  { }

  ngOnInit() {
    this.getClassifications();
  }

  getClassifications(): void {
    this.classificationService.getClassifications().subscribe(classifications => this.classifications = classifications);
  }
}
