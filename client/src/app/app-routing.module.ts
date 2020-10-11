import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ClassificationsComponent } from './components/classifications/classifications.component';
import { MountainComponent } from './components/mountain/mountain.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';

const routes: Routes = [
  {path: '', redirectTo: '/classifications', pathMatch: 'full'},
  { path: 'classifications/:id', component: ClassificationsComponent },
  { path: 'classifications', component: ClassificationsComponent },
  { path: 'mountain/:id', component: MountainComponent },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
