import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { ClassificationsComponent } from './components/classifications/classifications.component';
import { MountainComponent } from './components/mountain/mountain.component';
import { LegalComponent } from './components/legal/legal.component';
import { PageNotFoundComponent } from './components/page-not-found/page-not-found.component';
import { HomeComponent } from './components/home/home.component';
import { SearchComponent } from './components/search/search.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'search/:term', component: SearchComponent },
  { path: 'search', component: SearchComponent },
  { path: 'classifications/:id', component: ClassificationsComponent },
  { path: 'classifications', component: ClassificationsComponent },
  { path: 'mountain/:id', component: MountainComponent },
  { path: 'legal/:type', component: LegalComponent },
  { path: '**', component: PageNotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    scrollPositionRestoration: 'top',
    relativeLinkResolution: 'legacy'
})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
