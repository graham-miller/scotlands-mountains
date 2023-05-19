import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute, ParamMap } from '@angular/router';

import { MountainsService } from '../../services/mountains.service';
import { Mountain } from '../../models/Mountain';

@Component({
  selector: 'app-mountain',
  templateUrl: './mountain.component.html',
  styleUrls: ['./mountain.component.css']
})
export class MountainComponent implements OnInit {
  mountain: Mountain;

  constructor(
    private route: ActivatedRoute,
    private mountainsService: MountainsService)
  { }

  ngOnInit() {
    this.getMountain();
  }

  getMountain(): void {
    const id = this.route.snapshot.paramMap.get('id');
    this.mountainsService.getMountain(id).subscribe(mountain => this.mountain = mountain);
  }
}
