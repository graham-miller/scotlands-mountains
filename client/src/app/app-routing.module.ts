import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ClassificationsComponent } from './components/classifications/classifications.component';
import { MountainComponent } from './components/mountain/mountain.component';
import { LegalComponent } from './components/legal/legal.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';

const routes: Routes = [
  { path: '', redirectTo: '/classifications', pathMatch: 'full' },
  { path: 'classifications/:id', component: ClassificationsComponent },
  { path: 'classifications', component: ClassificationsComponent },
  { path: 'mountain/:id', component: MountainComponent },
  { path: 'legal/:type', component: LegalComponent },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    scrollPositionRestoration: 'top'
  })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
