import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GettyComponent } from './getty.component';

describe('GettyComponent', () => {
  let component: GettyComponent;
  let fixture: ComponentFixture<GettyComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ GettyComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(GettyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
