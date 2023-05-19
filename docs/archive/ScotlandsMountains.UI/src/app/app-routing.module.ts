import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ClassificationsComponent } from './Components/classifications/classifications.component';
import { LegalComponent } from './Components/legal/legal.component';
import { MountainComponent } from './Components/mountain/mountain.component';
import { PageNotFoundComponent } from './Components/page-not-found/page-not-found.component';
import { SearchComponent } from './Components/search/search.component';

const routes: Routes = [
  { path: '', redirectTo: 'classifications', pathMatch: 'full' },// component: HomeComponent },
  { path: 'classifications/:id', component: ClassificationsComponent },
  { path: 'classifications', component: ClassificationsComponent },
  { path: 'mountains/:id', component: MountainComponent },
  { path: 'search', component: SearchComponent },
  { path: 'legal/:type', component: LegalComponent },
  { path: '404', component: PageNotFoundComponent },
  { path: '**', redirectTo: '/404' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {
    scrollPositionRestoration: 'top'
  })],
  exports: [RouterModule]
})
export class AppRoutingModule { }
