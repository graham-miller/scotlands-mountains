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
  classifications: Classification[];
  selected = new Classification();

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private classificationService: ClassificationsService) { }

  ngOnInit() {
    this.getClassifications();
    this.route.params.subscribe(route => {
      this.selected.id = route.id
      this.getClassification()
    });
  }

  getClassifications(): void {
    this.classificationService
      .getClassifications()
      .subscribe(c => {
        this.classifications = c;
        this.loading = false;
      });
  }

  getClassification() {
    if (this.selected.id) {
      this.loading = true;
      this.classificationService
        .getClassification(this.selected.id)
        .subscribe(c => {
          this.selected = c;
          this.loading = false;
        });
    }
  }

  onClassificationChange(event: MatSelectChange): void {
    this.selected = { id: this.selected.id } as Classification;
    const command = [(this.route.snapshot.paramMap.get('id') ? '../' : '') + this.selected.id];
    this.router.navigate(command, { relativeTo: this.route });
  }
}
