<%-- 
    Document   : services
    Created on : 31 Jan 2025, 3:09:33 pm
    Author     : sraud
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/services.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/header.jspf" %>
        <div class="container my-5">
            <h2 class="text-center mb-5">Our Pharmacy Services</h2>

            <div class="row">
                <!-- Service 1: Prescription Medication -->
                <div class="col-md-4">
                    <div class="card service-card">
                        <img src="images/prescription_meds.jpg" class="card-img-top" alt="Prescription Medication">
                        <div class="card-body">
                            <h5 class="card-title">Prescription Medication</h5>
                            <p class="card-text">Our pharmacy offers fast and accurate prescription filling. We work directly with your healthcare provider to ensure you get the right medications on time.</p>
                            <button href="#prescription-details" class="learn-more-btn">Learn More</button>
                        </div>
                    </div>
                </div>

                <!-- Service 2: Over-the-Counter Products -->
                <div class="col-md-4">
                    <div class="card service-card">
                        <img src="images/med_over_counter.jpg" class="card-img-top" alt="Over-the-Counter Products">
                        <div class="card-body">
                            <h5 class="card-title">Over-the-Counter Products</h5>
                            <p class="card-text">We carry a wide range of over-the-counter products, including pain relievers, cold and flu treatments, vitamins, and first-aid supplies to meet your health needs.</p>
                            <button href="#otc-details" class="learn-more-btn">Learn More</button>
                        </div>
                    </div>
                </div>

                <!-- Service 3: Vaccinations -->
                <div class="col-md-4">
                    <div class="card service-card">
                        <img src="images/med_sync.jpg" class="card-img-top" alt="Medication Synchronization">
                        <div class="card-body">
                            <h5 class="card-title">Medication Synchronization</h5>
                            <p class="card-text">This service helps patients align the refill dates of all their medications so that they can pick up their prescriptions in one visit.</p>
                            <button href="#sync-details" class="learn-more-btn">Learn More</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Additional Services (Optional) -->
            <div class="row mt-4">
                <!-- Service 4: Medication Therapy Management -->
                <div class="col-md-4">
                    <div class="card service-card">
                        <img src="images/med_therapy.jpg" class="card-img-top" alt="Medication Therapy Management">
                        <div class="card-body">
                            <h5 class="card-title">Medication Therapy Management</h5>
                            <p class="card-text">Our pharmacists provide one-on-one counseling to ensure you understand how to take your medications properly and avoid potential interactions or side effects.</p>
                            <button href="#therapy-details" class="learn-more-btn">Learn More</button>
                        </div>
                    </div>
                </div>

                <!-- Service 5: Health Screenings -->
                <div class="col-md-4">
                    <div class="card service-card">
                        <img src="images/health_screening.jpg" class="card-img-top" alt="Health Screenings">
                        <div class="card-body">
                            <h5 class="card-title">Health Screenings</h5>
                            <p class="card-text">We offer a variety of health screenings, including blood pressure checks, cholesterol testing, glucose monitoring, and more to help you stay on top of your health.</p>
                            <button href="#screening-details" class="learn-more-btn">Learn More</button>
                        </div>
                    </div>
                </div>

                <!-- Service 6: Prescription Delivery -->
                <div class="col-md-4">
                    <div class="card service-card">
                        <img src="images/prescription_delivery.jpg" class="card-img-top" alt="Prescription Delivery">
                        <div class="card-body">
                            <h5 class="card-title">Prescription Delivery</h5>
                            <p class="card-text">For your convenience, we offer home delivery of your prescriptions. You can have your medications delivered directly to your home, ensuring ease and peace of mind.</p>
                            <button href="#delivery-details" class="learn-more-btn">Learn More</button>
                        </div>
                    </div>
                </div>

                <div>
                    <!-- Service Details Section (Hidden initially) -->
                    <div id="prescription-details" class="service-details">
                        <h3>Prescription Medication Details</h3>
                        <p>Pharmacy prescription medication services include:</p>
                        <ul>
                            <li>Dispensing prescribed medications</li>
                            <li>Providing medication counseling and dosage instructions</li>
                            <li>Identifying potential drug interactions</li>
                        </ul>
                    </div>

                    <div id="otc-details" class="service-details">
                        <h3>Over-the-Counter Medication Details</h3>
                        <p>Our over-the-counter services include:</p>
                        <ul>
                            <li>Providing a range of OTC medications, from pain relievers to allergy treatments</li>
                            <li>Personalized advice on choosing the right products</li>
                            <li>Available in-store and online for your convenience</li>
                        </ul>
                    </div>

                    <div id="sync-details" class="service-details">
                        <h3>Medication Synchronization Details</h3>
                        <p>We helps patients align the refill dates of all their medications:</p>
                        <ul>
                            <li>Aligning refill dates to improve convenience</li>
                            <li>Reducing the number of visits to the pharmacy</li>
                            <li>Helps improve medication adherence</li>
                        </ul>
                    </div>

                    <div id="therapy-details" class="service-details">
                        <h3>Medication Therapy Management Details</h3>
                        <p>Our pharmacists help you understand your medications and improve adherence.</p>
                        <ul>
                            <li>Reviewing and managing medications to avoid drug interactions</li>
                            <li>Assessing the effectiveness of prescribed medications</li>
                            <li>Providing education on chronic disease management (e.g., diabetes, asthma)</li>
                            <li>Ensuring patients adhere to their prescribed therapy</li>
                        </ul>
                    </div>

                    <div id="screening-details" class="service-details">
                        <h3>Health Screenings Details</h3>
                        <p>We offer screenings for blood pressure, cholesterol, diabetes, and more.</p>
                        <ul>
                            <li><b>Blood Pressure Testing</b>: For monitoring hypertension (high blood pressure)</li>
                            <li><b>Blood Glucose Testing</b>: For diabetes management or early detection</li>
                            <li><b>Cholesterol Screening</b>: To assess heart health</li>
                            <li><b>BMI (Body Mass Index) Measurement</b>: To track weight management</li>
                            <li><b>Bone Density Testing</b>: To screen for osteoporosis in older adults</li>
                        </ul>
                    </div>

                    <div id="delivery-details" class="service-details">
                        <h3>Prescription Delivery Details</h3>
                        <p>We provide home delivery for your prescriptions for convenience and safety.</p>
                        <ul>
                            <li><b>Convenient delivery of medications to a customer’s home</li>
                            <li><b>Timely and reliable delivery services</li>
                            <li><b>We also offer same-day or next-day delivery</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
        <%@ include file="WEB-INF/jspf/footer.jspf" %>

        <button id="goUpBtn" title="Go to top">&uarr;</button>
        
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const learnMoreButtons = document.querySelectorAll('.learn-more-btn');
                const goUpBtn = document.getElementById('goUpBtn');
                
                learnMoreButtons.forEach(button => {
                    button.addEventListener('click', function (e) {
                        e.preventDefault(); // Prevent default anchor behavior
                        const targetId = this.getAttribute('href').substring(1); // Extract target ID
                        const targetSection = document.getElementById(targetId);
                        
                        if (targetSection) {
                            document.querySelectorAll('.service-details').forEach(section => {
                                section.classList.remove('show-details');
                            });
                            
                            targetSection.classList.add('show-details');
                            targetSection.scrollIntoView({behavior: 'smooth', block: 'start'});
                        }
                    });
                });
                
                window.addEventListener('scroll', function () {
                    if (window.scrollY > 300) {
                        goUpBtn.style.display = 'block';
                    } else {
                        goUpBtn.style.display = 'none';
                    }
                });
                
                goUpBtn.addEventListener('click', function () {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                });
            });
        </script>
    </body>
</html>

