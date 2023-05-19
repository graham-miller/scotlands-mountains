import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Classification } from 'src/app/Models/Classification';
import { Mountain } from 'src/app/Models/Mountain';
import { MountainDataService } from 'src/app/Services/MountainDataService';

@Component({
  selector: 'app-classifications',
  templateUrl: './classifications.component.html',
  styleUrls: ['./classifications.component.scss']
})
export class ClassificationsComponent implements OnInit {
  classifications: Classification[] = [];
  selectedClassificationId: string | undefined;
  description: string = '';
  mountains: Mountain[] = [];
  
  constructor(
      private route: ActivatedRoute,
      private router: Router,
      private mountainDataService: MountainDataService
  ) { }

  ngOnInit(): void {
      this.route.params.subscribe(route => {
          this.selectedClassificationId = route.id
          this.getClassification()
      });

      this.mountainDataService.getClassifications().subscribe((response) => {
          this.classifications = response;
          if (!this.selectedClassificationId) {
              this.selectedClassificationId = this.classifications.sort(c =>c.displayOrder)[0].id;
              this.navigateToClassification()
          }
      });
  }

  getClassification() {
      if (this.selectedClassificationId) {
          this.mountainDataService.getClassification(this.selectedClassificationId).subscribe((response) => {
              if (response) {
                this.selectedClassificationId = response.id;
                this.description = response.description;
                this.mountains = response.mountains;
              } else {
                this.router.navigate(['/404'], { skipLocationChange: true });
              }
          });
      }
  }

  navigateToClassification() {
      const command = [(this.route.snapshot.paramMap.get('id') ? '../' : '') + this.selectedClassificationId];
      this.router.navigate(command, { relativeTo: this.route });
  }
}