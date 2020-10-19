import { Component,  OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MatSelectChange } from '@angular/material/select';
import { ActivatedRoute } from '@angular/router';

import { Classification } from 'src/app/models/Classification';
import { Mountain } from 'src/app/models/Mountain';
import { ClassificationsService } from 'src/app/services/classifications.service';

@Component({
  selector: 'app-classifications',
  templateUrl: './classifications.component.html',
  styleUrls: ['./classifications.component.css']
})
export class ClassificationsComponent implements OnInit {
  loading: boolean = true;
  all: Classification[];
  id: string;
  name: string;
  description: string;
  mountains: Mountain[];

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

  getClassifications(): void {
    this.classificationService
      .getClassifications()
      .subscribe(c => {
        this.all = c;
        this.loading = false;
      });
  }

  getClassification() {
    if (this.id) {
      this.loading = true;
      this.classificationService
        .getClassification(this.id)
        .subscribe(c => {
          this.mountains = c.mountains;
          this.name = c.name;
          this.description = c.description;
          this.loading = false;
        });
    }
  }

  onClassificationChange(event: MatSelectChange): void {
    this.mountains = null;
    const command = [(this.route.snapshot.paramMap.get('id') ? '../' : '') + this.id];
    this.router.navigate(command, { relativeTo: this.route });
  }
}
