//  Created by Martin Kock on 10/12/2023.
//

import Foundation
@preconcurrency import FirebaseAuth

actor FirebaseAuthService {
    
    // MARK: - Private init
    init() {}
    
    // MARK: - private properties
    private let auth = Auth.auth()
    private var verificationId: String?
    private var stateListener: AuthStateDidChangeListenerHandle!
    
    // MARK: - Public properties
    
    // MARK: - Private functions
    private func startAuthStateListener() {
        stateListener = auth.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in
                print("User is signed in: \(user.uid)")
            } else {
                // User is signed out
                print("User is signed out")
            }
        }
    }
    
    // MARK: - public functions
    func sendVerificationCode(to phoneNumber: String) async throws {
        do {
            let id = try await PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            verificationId = id
            UserDefaults.standard.set(id, forKey: "authVerificationID")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loginUser(with authCode: String) async throws -> Bool {
        do {
            let credentials = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationId!,
                verificationCode: authCode
            )
            let result = try await Auth.auth().signIn(with: credentials)
            print(result.user.uid)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    


    
}
