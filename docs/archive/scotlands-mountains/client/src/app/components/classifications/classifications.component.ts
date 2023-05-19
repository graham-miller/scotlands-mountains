import { Component,  OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ActivatedRoute } from '@angular/router';

import { Classification } from 'src/app/models/Classification';
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
      .subscribe(classifications => {
        this.classifications = classifications;
        if (!this.selected.id) {
          this.displayClassification();
        }
      });
  }

  getClassification() {
    if (this.selected.id) {
      this.loading = true;
      this.classificationService
        .getClassification(this.selected.id)
        .subscribe(classification => {
          this.selected = classification;
          this.loading = false;
        });
    }
  }

  displayClassification(): void {
    const id = this.selected.id || this.classifications[0].id;
    const command = [(this.route.snapshot.paramMap.get('id') ? '../' : '') + id];
    this.router.navigate(command, { relativeTo: this.route });
  }
}
